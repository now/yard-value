# -*- coding: utf-8 -*-

# Namespace for YARD extensions for Value.
module YARDValue
  load File.expand_path('../yard-value-1.0/version.rb', __FILE__)
  Version.load
end

class YARD::Handlers::Ruby::ValuesHandler < YARD::Handlers::Ruby::Base
  handles method_call('Value')
  namespace_only

  process do
    parameters = statement.parameters(false)
    if YARD::Parser::Ruby::AstNode === parameters[-1][0] and
        parameters[-1][0].type == :assoc and
        comparable = parameters[-1].find{ |e| e.jump(:ident).source == 'comparable' }
      parameters.pop
      comparables = (comparable[1].type == :array and comparable[1][0].map{ |e| e.jump(:ident).source })
      ancestor 'Comparable'
      ancestor 'Value::Comparable'
    end
    ancestor 'Value'
    initialize = define('initialize', parameters.map{ |e| [e.jump(:ident).source, e.type == :array ? e[0][1].source : nil] })
    if initialize.parameters.last.first =~ /\A&/
      base = initialize.parameters.last.first.sub(/\A&/, '')
      if tag = initialize.docstring.tags.find{ |e| e.tag_name == 'param' and e.name == base }
        tag.types = %w'Proc' unless tag.types
      else
        initialize.docstring.add_tag YARD::Tags::Tag.new(:param, '', %w'Proc', base)
      end
    end
    initialize.docstring.tags(:param).select{ |e| e.text and not e.text.empty? }.each do |e|
        define e.name.sub(/\A[&*]/, ''), [],
               '@return [%s] %s' % [e.types ? e.types.join(', ') : '', e.text], :protected
        e.text = ''
      end
    initialize.docstring.add_tag(YARD::Tags::Tag.new(:note, 'Comparisons between instances are made between %s.' % join(comparables))) if comparables
  end

  def ancestor(name)
    modul = Proxy.new(:root, name).tap{ |m| m.type = :module }
    namespace.mixins(scope).unshift(modul) unless namespace.mixins(scope).include? modul
  end

  def define(name, parameters, docstring = nil, visibility = :public)
    YARD::CodeObjects::MethodObject.new(namespace, name).tap{ |m|
      register m
      register_docstring m, docstring if docstring
      m.signature = 'def %s%s' %
        [name,
         parameters.empty? ?
           '' :
           '(%s)' % parameters.map{ |n, d| d ? '%s = %s' % [n, d] : n }.join(', ')]
      m.parameters = parameters
      m.visibility = visibility
    }
  end

  def join(items)
    return items.join('') if items.size < 2
    return items.join(' and ') if items.size < 3
    return '%s, and %s' % [items[0..-2].join(', '), items[-1]]
  end
end
