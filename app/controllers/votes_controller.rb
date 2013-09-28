class VotesController < ApplicationController
  respond_to :json
  before_action :set_vote, only: []
  before_action :set_votes_by_category, only: %i(count index ranking)

  # GET /votes/count.json
  def count
    if params[:name]
      @votes = @votes.of_name(params[:name])
    end
  end

  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.remote_ip = request.remote_ip
    @vote.user_agent = request.env['HTTP_USER_AGENT']

    respond_to do |format|
      if !@vote.suspicious? && @vote.save
        format.json { render json: { message: 'OK' }, status: :created }
      else
        format.json { render json: { errors: @vote.errors, message: 'NG' }, status: :unprocessable_entity }
      end
    end
  end

  # GET /votes.json
  def index
    if params[:name]
      @votes = @votes.of_name(params[:name])
    end
  end

  # GET /votes/ranking.json
  def ranking
    @votes = Vote.category(params[:category])
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  def set_votes_by_category
    if params[:category].present?
      @votes = Vote.category(params[:category])
    else
      render json: { message: 'NG' }, status: :forbidden
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote).permit(:category, :name)
  end
end
