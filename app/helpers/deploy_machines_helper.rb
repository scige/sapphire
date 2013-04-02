module DeployMachinesHelper
  def get_machine_status_option
    options = []
    options << [Setting.deploy_machine_status.active, Setting.deploy_machine_status.active]
    options << [Setting.deploy_machine_status.dead, Setting.deploy_machine_status.dead]
    options << [Setting.deploy_machine_status.running, Setting.deploy_machine_status.running]
    options << [Setting.deploy_machine_status.deploy_success, Setting.deploy_machine_status.deploy_success]
    options << [Setting.deploy_machine_status.deploy_failed, Setting.deploy_machine_status.deploy_failed]
    options << [Setting.deploy_machine_status.rollback_success, Setting.deploy_machine_status.rollback_success]
    options << [Setting.deploy_machine_status.rollback_failed, Setting.deploy_machine_status.rollback_failed]
  end
end
