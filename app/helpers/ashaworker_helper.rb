module AshaworkerHelper
  def resource_name
    :asha_worker
  end

  def resource
    @resource ||= AshaWorker.new
    @resource.ashaID = "AWID"+((Time.now.to_f)*10000).to_i.to_s
    @resource.username = current_user.username
    @resource
  end

end
