class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :broadcast, :count_broadcast]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @donors = Donor.not_broadcasters_of(@tweet.id)
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # GET /tweets/1/broadcast
  # GET /tweets/1/broadcast
  def count_broadcast
    donors = Donor.for_broadcasting @tweet, params[:broadcast]
    respond_to do |format|
      format.html { redirect_to tweet_url(@tweet) }
      format.json { render(json: {donors_count: donors.count}) }
    end
  end

  # POST /tweets/1/broadcast
  # POST /tweets/1/broadcast
  def broadcast
    @tweet.broadcast params[:broadcast]
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully scheduled for broadcasting.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:text, :action, :image, :status, :remove_image, :remote_image_url)
    end
end
