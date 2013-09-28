class VotesController < ApplicationController
  respond_to :json
  before_action :set_vote, only: []

  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.remote_ip = request.remote_ip
    @vote.user_agent = request.env['HTTP_USER_AGENT']

    respond_to do |format|
      if !@vote.suspicious? && @vote.save
        format.json { render action: 'show', status: :created, location: @vote }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /votes.json
  def index
    if params[:category]
      @votes = Vote.category(params[:category])
    else
      @votes = Vote.all
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote).permit(:category, :name)
  end
end
