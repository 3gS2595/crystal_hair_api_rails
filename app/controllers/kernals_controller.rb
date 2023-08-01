class KernalsController < ApplicationController
  before_action :set_kernal, only: %i[ show update destroy ]

  # GET /kernals
  def index
    @q = Kernal.ransack(search_params)
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    render json:  @q.result
  end

  # GET /kernals/1
  def show
    render json: @kernal
  end

  # POST /kernals
  def create
    @kernal = Kernal.new(kernal_params)

    if @kernal.save
      render json: @kernal, status: :created, location: @kernal
    else
      render json: @kernal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kernals/1
  def update
    if @kernal.update(kernal_params)
      render json: @kernal
    else
      render json: @kernal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kernals/1
  def destroy
    @kernal.destroy
  end

  private
    def search_params
      key = ""
      Kernal.column_names.each do |e|
        key = key + e + "_or_"
      end
      key.chomp('_or_')
      key = key + "_cont"
      default_params = {key => params[:q]}
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_kernal
      @kernal = Kernal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kernal_params
      params.require(:kernal)
      params.permit(:hypertext_id, :source_url_id, :file_type, :file_name, :file_path, :url, :size, :author, :time_posted, :time_scraped, :description, :key_words, :hashtags, :likes, :reposts)
    end
end
