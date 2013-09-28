class VotesController < ApplicationController
  respond_to :json
  before_action :set_vote, only: [:show]

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)

    respond_to do |format|
      if @vote.save
        format.json { render action: 'show', status: :created, location: @vote }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
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
