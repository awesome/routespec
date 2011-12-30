class ChipsController < ApplicationController
  # GET /chips
  # GET /chips.json
  def index
    @chips = Chip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chips }
    end
  end

  # GET /chips/1
  # GET /chips/1.json
  def show
    @chip = Chip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chip }
    end
  end

  # GET /chips/new
  # GET /chips/new.json
  def new
    @chip = Chip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chip }
    end
  end

  # GET /chips/1/edit
  def edit
    @chip = Chip.find(params[:id])
  end

  # POST /chips
  # POST /chips.json
  def create
    @chip = Chip.new(params[:chip])

    respond_to do |format|
      if @chip.save
        format.html { redirect_to @chip, notice: 'Chip was successfully created.' }
        format.json { render json: @chip, status: :created, location: @chip }
      else
        format.html { render action: "new" }
        format.json { render json: @chip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chips/1
  # PUT /chips/1.json
  def update
    @chip = Chip.find(params[:id])

    respond_to do |format|
      if @chip.update_attributes(params[:chip])
        format.html { redirect_to @chip, notice: 'Chip was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @chip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chips/1
  # DELETE /chips/1.json
  def destroy
    @chip = Chip.find(params[:id])
    @chip.destroy

    respond_to do |format|
      format.html { redirect_to chips_url }
      format.json { head :ok }
    end
  end
end
