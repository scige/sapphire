class AutoDeployController < ApplicationController
  def initialize
    super
    @test_machine_spec = ""
    @production_machine_spec = ""
    @static_username = ""
    @static_password = ""
  end

  def index
  end

  def ready_deploy
  end
end
