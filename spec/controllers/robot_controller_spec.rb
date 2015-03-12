require 'rails_helper'

RSpec.describe RobotController, type: :controller do

  describe "#GET/#POST index" do
    it "should catch params via #GET" do
      get :index, m: "", x: "2", y: "3", f: "North"

      expect(assigns(:m)).to eq nil
      expect(assigns(:x)).to eq 2
      expect(assigns(:y)).to eq 3
      expect(assigns(:facing)).to eq "North"
      expect(flash[:notice]).to be_blank
    end

    it "should catch params via #POST" do
      post :index, m: "", x: "1", y: "4", f: "North"

      expect(assigns(:m)).to eq nil
      expect(assigns(:x)).to eq 1
      expect(assigns(:y)).to eq 4
      expect(assigns(:facing)).to eq "North"
      expect(flash[:notice]).to be_blank
    end
  end

  describe "Instructions" do
    it "should ask for starting point" do
      get :index
      expect(assigns[:instruction]).to eq "Please enter a starting place."
    end

    it "should ask for next move" do
      get :index, f: "North"
      expect(assigns[:instruction]).to eq "Whats your next move!?"
    end
  end

  describe "Errors" do
    it "should be starting point" do
      get :index
      expect(assigns[:instruction]).to eq "Please enter a starting place."
    end

    it "should not move" do
      post :index, m: "straight", x: "2", y: "3", f: "North"
      expect(assigns(:errors).size).to eq 1
      expect(response).to render_template :index
    end

    it "should not change facing direction" do
      post :index, m: "step", x: "2", y: "3", f: "North West"
      expect(assigns(:errors).size).to eq 1
      expect(response).to render_template :index
    end

    it "should not change facing direction" do
      post :index, m: "turn", d: "LeftRight", x: "2", y: "3", f: "North"
      expect(assigns(:errors).size).to eq 1
      expect(response).to render_template :index
    end

    it "x should be invalid high" do
      post :index, x: "5", y: "4", f: "North"
      expect(assigns(:errors).size).to eq 1
      expect(response).to render_template :index
    end

    it "x should be invalid low" do
      post :index, x: "-2", y: "4", f: "North"
      expect(assigns(:errors).size).to eq 1
      expect(response).to render_template :index
    end

    it "y should be invalid high" do
      post :index, x: "2", y: "5", f: "North"
      expect(assigns(:errors).size).to eq 1
      expect(response).to render_template :index
    end

    it "y should be invalid low" do
      post :index, x: "2", y: "-1", f: "North"
      expect(assigns(:errors).size).to eq 1
      expect(response).to render_template :index
    end

    it "should report all errors" do
      post :index, m:"Straight", d: "LeftRight", x: "6", y: "-1", f: "NorthWest"
      expect(assigns(:errors).size).to eq 5
      expect(response).to render_template :index
    end
  end

  describe "Robot Step" do
    it "should move the robot up" do
      post :index, m: "step", x: "2", y: "2", f: "North"
      expect(assigns(:commands)[:y]).to eq 3
      expect(assigns(:commands)[:x]).to eq 2
      expect(flash[:notice]).to be_blank
    end

    it "should move the robot left" do
      post :index, m: "step", x: "2", y: "2", f: "West"
      expect(assigns(:commands)[:x]).to eq 1
      expect(assigns(:commands)[:y]).to eq 2
      expect(flash[:notice]).to be_blank
    end

    it "should move the robot down" do
      post :index, m: "step", x: "2", y: "2", f: "South"
      expect(assigns(:commands)[:x]).to eq 2
      expect(assigns(:commands)[:y]).to eq 1
      expect(flash[:notice]).to be_blank
    end

    it "should move the robot right" do
      post :index, m: "step", x: "2", y: "2", f: "East"
      expect(assigns(:commands)[:x]).to eq 3
      expect(assigns(:commands)[:y]).to eq 2
      expect(flash[:notice]).to be_blank
    end

    it "should halt falling off North" do
      post :index, m: "step", x: "2", y: "4", f: "North"
      expect(assigns(:commands)[:x]).to eq 2
      expect(assigns(:commands)[:y]).to eq 4
    end

    it "should halt falling off West" do
      post :index, m: "step", x: "0", y: "2", f: "West"
      expect(assigns(:commands)[:x]).to eq 0
      expect(assigns(:commands)[:y]).to eq 2
    end

    it "should halt falling off South" do
      post :index, m: "step", x: "2", y: "0", f: "South"
      expect(assigns(:commands)[:x]).to eq 2
      expect(assigns(:commands)[:y]).to eq 0
    end

    it "should halt falling off East" do
      post :index, m: "step", x: "4", y: "2", f: "East"
      expect(assigns(:commands)[:x]).to eq 4
      expect(assigns(:commands)[:y]).to eq 2
    end

    it "should redirect to root" do
      post :index, m: "step", x: "0", y: "0", f: "North"
      expect(response).to redirect_to root_path(x: "0", y: "1", f: "North")
    end
  end

  describe "Robot Turn Left" do
    it "should turn West" do
      post :index, m: "turn", d: "Left", x: "0", y: "0", f: "North"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "West")
    end

    it "should turn South" do
      post :index, m: "turn", d: "Left", x: "0", y: "0", f: "West"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "South")
    end

    it "should turn East" do
      post :index, m: "turn", d: "Left", x: "0", y: "0", f: "South"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "East")
    end

    it "should turn North" do
      post :index, m: "turn", d: "Left", x: "0", y: "0", f: "East"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "North")
    end
  end

  describe "Robot Turn Right" do
    it "should turn East" do
      post :index, m: "turn", d: "Right", x: "0", y: "0", f: "North"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "East")
    end

    it "should turn South" do
      post :index, m: "turn", d: "Right", x: "0", y: "0", f: "East"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "South")
    end

    it "should turn West" do
      post :index, m: "turn", d: "Right", x: "0", y: "0", f: "South"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "West")

    end

    it "should turn North" do
      post :index, m: "turn", d: "Right", x: "0", y: "0", f: "West"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "North")
    end
  end

  describe "Robot Report" do
    it "should report location" do
      post :index, m: "report", x: "0", y: "0", f: "North"
      expect(flash[:notice]).to eq "0, 0, North"
      expect(response).to redirect_to root_path(x: "0", y: "0", f: "North")
    end
  end

end
