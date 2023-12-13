class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show log edit update destroy ]
  before_action :authenticate_account!, only: %i[ visited owned searched show subscribed new edit create update destroy ]
  before_action :add_sentry_context, only: %i[ show log edit create update destroy ]
  before_action :set_chat_users_online, only: %i[ show ]

  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  # GET /chats or /chats.json
  def index
    @pagy, @chats = pagy(Chat.listed, items: 30)
  end

  # GET /chat/something or /chat/something.json
  def show
    authorize! @chat, to: :show?
    if UNLEASH.is_disabled? "beta", @unleash_context
      redirect_to log_chat_path(@chat)
      return
    end

    @messages = @chat.messages.order(posted: 'DESC').first(100).reverse
    render :layout => 'application_chat'
  end

  # GET /chat/something/log or /chat/something/log.json
  def log
    authorize! @chat, to: :show?
    
    params.permit(:date_between, :commit, :id)

    start = @chat.created
    finish = @chat.last_message

    if params[:date_between]
      date_split = params[:date_between].split(" - ")
      if date_split.size == 2
        start = date_split[0]
        finish = date_split[1]
      end
    end
    @pagy, @messages = pagy(@chat.messages.between(start, finish), size:  [1, 3, 3, 1], items: 100 )
    render :layout => 'application_chat'
  end
  
  # GET /chats/visited
  def visited
    @pagy, @chats = pagy(Chat.user_involved(current_account), items: 30)
  end

  # GET /chats/searched
  def searched
    @pagy, @chats = pagy(Chat.user_searched(current_account), items: 30)
  end

  # GET /chats/subscribed
  def subscribed
    @pagy, @chats = pagy(current_account.chats.subscribed, items: 30)
  end

  # GET /chats/owned
  def owned
    @pagy, @chats = pagy(Chat.owned_by(current_account), items: 30)
  end

  # GET /chats/new
  def new
    @chat = Chat.new
    authorize! @chat, to: :create?
  end

  # GET /chat/something/edit
  def edit
    authorize! @chat, to: :update?
  end

  # POST /chats or /chats.json
  def create
    @chat = Chat.new(chat_params)
    authorize! @chat, to: :create?

    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully created." }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chat/something or /chat/something.json
  def update
    authorize! @chat, to: :update?

    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat/something or /chat/something.json
  def destroy
    authorize! @chat, to: :destroy?

    @chat.destroy!

    respond_to do |format|
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find_by_url(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:url, :type, :last_message)
    end

    def set_chat_users_online
      online_chat_users = Kredis.unique_list("chat_#{@chat.id}_accounts_online")
      @online_chat_users = ChatUser.where(chat_id: @chat.id, user_id: online_chat_users.elements)
    end

    def pagy_calendar_period(messages)
      minmax = messages.pluck('MIN(posted)', 'MAX(posted)').first
      minmax.map { |time| time.in_time_zone }
    end

    def pagy_calendar_filter(messages, from, to)
      messages.where(posted: from...to)
    end

    def redirect_to_last_page(exception)
      redirect_to url_for(page: exception.pagy.last), notice: "Page ##{params[:page]} is overflowing. Showing page #{exception.pagy.last} instead."
    end

    def add_sentry_context
      if !@chat.nil?
        Sentry.configure_scope do |scope|
          scope.set_context(
            'Chat',
            {
              name: @chat.url,
              id: @chat.id,
              type: @chat.type
            }
          )
        end
      end   
    end

end
