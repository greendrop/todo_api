module BootstrapHelper
  ALERT_TYPES = ["danger", "info", "success", "warning"] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = "success" if type == "notice"
      type = "danger"  if type == "alert"
      type = "danger"  if type == "error"
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div, content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") + msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def bootstrap_form_group(model, attribute, &block)
    style = "form-group"
    style << " has-error" if model.errors.include?(attribute)
    options = { class: style }
    if block_given?
      content_tag(:div, capture(&block), options)
    else
      content_tag(:div, nil, options)
    end
  end

  def bootstrap_error_message_on(model, attribute)
    errors = model.errors
    if errors.include?(attribute)
      messages = errors.get(attribute).map { |message| errors.full_message(attribute, message) }
      return content_tag("span", safe_join(messages, "<br />".html_safe), {class: "help-block"})
    end
  end

  def bootstrap_control_label(object, object_name, method, content = nil, options = {}, &block)
    options = options.symbolize_keys
    options[:class] = "#{options[:class]} " if options[:class].present?
    options[:class] = "#{options[:class]}control-label"

    if block_given?
      content = capture(&block)
    else
      content = object.class.human_attribute_name(method) if content.blank?
    end
    if options[:required].present? && options[:required] != false
      content = (content + '&nbsp;' + content_tag(:span, '*', {class: 'required'})).html_safe
      options.delete(:required)
    end

    option_for = "#{object_name.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")}_#{method}"
    option_for = options.delete(:for) if options[:for]

    label_tag option_for, content, options
  end

end

module ActionView
  module Helpers
    class FormBuilder
      def bootstrap_form_group(method, &block)
        @template.bootstrap_form_group(@object, method, &block)
      end

      def bootstrap_error_message_on(method)
        @template.bootstrap_error_message_on(@object, method)
      end

      def bootstrap_control_label(method, content = nil, options = {}, &block)
        if content.kind_of?(Hash)
          options = content
          content = nil
        end
        @template.bootstrap_control_label(@object, @object_name, method, content, options, &block)
      end
    end
  end
end

