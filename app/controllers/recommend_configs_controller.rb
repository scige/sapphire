class RecommendConfigsController < ApplicationController
  def index
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_configs = @table_schema.recommend_configs.page(params[:page])
  end

  def show
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_config = RecommendConfig.find(params[:id])
  end

  def new
    @table_schema = TableSchema.find_by(:table=>params[:table])
  end

  def edit
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_config = RecommendConfig.find(params[:id])
  end

  def create
    @recommend_config = RecommendConfig.new(params[params[:table]])

    if @recommend_config.save
      redirect_to recommend_config_url(@recommend_config, :owner=>params[:owner], :table=>params[:table]), notice: 'Recommend config was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @recommend_config = RecommendConfig.find(params[:id])

    if @recommend_config.update_attributes(params[:recommend_config])
      redirect_to recommend_config_url(@recommend_config, :owner=>params[:owner], :table=>params[:table]), notice: 'Recommend config was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @recommend_config = RecommendConfig.find(params[:id])
    @recommend_config.destroy

    redirect_to recommend_configs_url(:owner=>params[:owner], :table=>params[:table])
  end
end
