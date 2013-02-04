#coding: utf-8

require 'spec_helper'

describe "Home" do

  subject{ page }

  describe "when visit index" do
    before(:each) do
      visit root_path
    end

    #it { puts page.html }

    it { should have_content("首页") }
    it { should have_content("配置管理") }
    it { should have_content("数据表管理") }
    it { should have_content("配置&部署中心") }
    it { should have_content("配置&部署中心 V0.1") }
    it { should have_content("用户手册 V0.1") }

    it { should have_css(".container") }
    it { should have_selector("div.navbar-inner") }
  end
end
