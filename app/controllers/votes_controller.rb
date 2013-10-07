class VotesController < ApplicationController
  respond_to :json, only: %i(count destroy index ranking)
  respond_to :html, only: %i(count new)
  skip_before_filter :verify_authenticity_token, only: %i(create destroy)
  before_action :set_vote, only: %i(destroy)
  before_action :set_votes_by_category, only: %i(count index ranking)

  # GET /votes/count.json
  def count
    if params[:name]
      @votes = @votes.of_name(params[:name])
    end

    respond_to do |format|
      format.html { render layout: false }
      format.json { render }
    end
  end

  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.remote_ip = request.remote_ip
    @vote.user_agent = request.env['HTTP_USER_AGENT']

    respond_to do |format|
      if !@vote.suspicious? && @vote.save
        format.json { render status: :created, callback: params[:callback] }
      else
        format.json { render json: { errors: @vote.errors, message: 'NG' }, status: :unprocessable_entity, callback: params[:callback] }
      end
    end
  end

  # DELETE /votes/destroy.json
  def destroy
    @vote.delete
    render json: { message: 'OK', callback: params[:callback] }
  end

  # GET /votes.json
  def index
    if params[:name]
      @votes = @votes.of_name(params[:name])
    end
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/ranking.json
  def ranking
    @votes = Vote.category(params[:category]).asc(:created_at).only(:category, :name, :created_at)
    @ranking_hash = {}
    @votes.each do |vote|
      element = @ranking_hash[vote.name] || { name: vote.name, count: 0, position: 1 }
      element[:updated_at] = vote.created_at
      element[:count] += 1
      @ranking_hash[vote.name] = element
    end
    @ranking = @ranking_hash.values.sort do |a, b|
      b[:count] <=> a[:count]
    end
    past_ranking = nil
    @ranking.each_with_index do |element, i|
      if past_ranking && past_ranking[:count] == element[:count]
        element[:position] = past_ranking[:position]
      else
        element[:position] = i + 1
      end
      past_ranking = element
    end
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
