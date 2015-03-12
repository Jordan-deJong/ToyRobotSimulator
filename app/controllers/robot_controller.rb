class RobotController < ApplicationController

  before_action :catch_params, only: :index
  before_action :check_errors, only: :index

  def index
    # Set instructions
    if @facing.blank?
      @instruction = "Please enter a starting place."
    else
      @instruction = "Whats your next move!?"
      # Halt here until next move.
      unless @move.blank?
        # Get results from class
        results = Robot.send(@move, @commands)
        flash[:notice] = "#{results[:x]}, #{results[:y]}, #{results[:facing]}" if results[:move] == "report"
        redirect_to root_path(x: results[:x], y: results[:y], f: results[:facing])
      end
    end
  end

  private

    def catch_params
      # Set params
      @move = params[:m].to_s
      @direction = params[:d].to_s
      @facing = params[:f].to_s
      @x = params[:x].to_i
      @y = params[:y].to_i
      # Set commands as hash
      @commands = {move: @move, direction: @direction, facing: @facing, x: @x, y: @y}
    end

    def check_errors
      # Return error array and render
      @errors = Errors.check @commands
      render :index, x: @x, y: @y, f: @facing if @errors.size > 0
    end

end
