module ApplicationHelper
  def error_messages_for(*objects)
    html = ""
    objects = objects.map {|o| o.is_a?(String) ? instance_variable_get("@#{o}") : o}.compact
    errors = objects.map {|o| o.errors.full_messages}.flatten
    if errors.any?
      html << "<div id='errorExplanation'><ul>\n"
      errors.each do |error|
        html << "<li>#{h error}</li>\n"
      end
      html << "</ul></div>\n"
    end
    html.html_safe
  end

  def admin_user_flg()
    admin_flg = false

    SETTINGS["admin_user"].each do |user|
      if user.present?
        if (current_user.login == user)
          admin_flg = true
          break
        end
      end
    end

    return admin_flg
  end

  def ldap_juki_tab_flg()
    juki_flg = false

    SETTINGS["ldap_juki_setting"].each do |ldap_setting|
      if current_user.uid.include?(ldap_setting)
        juki_flg = true
        break
      end
    end

    return juki_flg
  end
end