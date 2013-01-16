class RecommendConfigsController < ApplicationController
  def index
    @table_schema = TableSchema.find_by(:table=>"sites")
    @recommend_configs = RecommendConfig.all
  end

  def show
    @table_schema = TableSchema.find_by(:table=>"sites")
    @recommend_config = RecommendConfig.find(params[:id])
  end

  def new
    @table_schema = TableSchema.find_by(:table=>"sites")
  end

  def edit
    @table_schema = TableSchema.find_by(:table=>"sites")
    @recommend_config = RecommendConfig.find(params[:id])
  end

  def create
    @recommend_config = RecommendConfig.new(params[:sites])
    #@recommend_config = RecommendConfig.new(params[@table_schema.table])

    if @recommend_config.save
      redirect_to @recommend_config, notice: 'Recommend config was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @recommend_config = RecommendConfig.find(params[:id])

    if @recommend_config.update_attributes(params[:recommend_config])
      redirect_to @recommend_config, notice: 'Recommend config was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @recommend_config = RecommendConfig.find(params[:id])
    @recommend_config.destroy

    redirect_to recommend_configs_url
  end
end
