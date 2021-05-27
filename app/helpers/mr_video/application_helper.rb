module MrVideo
  module ApplicationHelper
    def bootstrap_alert_class(flash_type)
      case flash_type.to_sym
      when :notice then "alert-info"
      when :success then "alert-success"
      when :error then "alert-danger"
      when :alert then "alert-danger"
      else "alert-#{flash_type}"
      end
    end
  end
end
