class AutoDeployController < ApplicationController
  def index
    @deploy_machines = DeployMachine.order_by([[:id, :asc]])
  end

  def deploy
  end
end
