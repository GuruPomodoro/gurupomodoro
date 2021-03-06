class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :settings, :set_trello_board]
  # GET /teams/1
  # GET /teams/1.json
  def show
    authorize! :show, @team
    if session[:team_id].present? && session[:team_id] != @team.id
      TeamChannel.broadcast_to(
        current_team,
        sent_by: current_user.id,
        body: 'Logout'
      )
      set_team_session
    elsif !session[:team_id].present?
      set_team_session
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    authorize! :edit, @team
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    team_user = TeamUser.new
    team_user.team = @team
    team_user.user = current_user
    team_user.user_type = 'leader'

    respond_to do |format|
      if @team.save && team_user.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    authorize! :edit, @team
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to root_path, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def settings
    authorize! :edit, @team
    @trello_boards = current_user.trello_boards
    if @team.trello_board_id.present?
      selected_trello_board = @trello_boards.select { |board| board['id'] == @team.trello_board_id }
      @trello_boards = @trello_boards.delete_if { |board| board['id'] == @team.trello_board_id }
      @trello_boards = selected_trello_board + @trello_boards
    end
    @team_invitation = TeamInvitation.new
  end

  def set_trello_board
    authorize! :edit, @team
    @team.trello_board_id = params[:trello_board_id]
    @team.save
    redirect_to settings_team_path(@team)
  end

  private

    def set_team_session
      session[:team_id] = @team.id
      TeamChannel.broadcast_to(
        current_team,
        sent_by: current_user.id,
        body: 'Login'
      )
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.fetch(:team).permit(:title, :description)
    end
end
