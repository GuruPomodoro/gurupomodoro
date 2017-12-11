module ApplicationHelper
  def flash_class(type)
    {success: 'alert-success', error: 'alert-warning', alert: 'alert-danger', notice: 'alert-info'}[type.to_sym] || type.to_s
  end
end
