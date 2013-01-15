class RecommendConfigsController < ApplicationController
  def index
    @recommend_configs = RecommendConfig.all
  end

  def show
    @table_schema = TableSchema.find_by(:table=>"sites")
    @recommend_config = RecommendConfig.find(params[:id])
  end

  def new
    @table_schema = TableSchema.find_by(:table=>"sites")
  end

  def create
    @recommend_config = RecommendConfig.new(params[:sites])
    logger.debug params[:sites]
    #@recommend_config = RecommendConfig.new(params[@table_schema.table])

    if @recommend_config.save
      redirect_to @recommend_config, notice: 'Recommend config was successfully created.'
    else
      render action: "new"
    end
  end
end
