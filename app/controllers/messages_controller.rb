class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_account!, only: %i[ new index edit create update destroy ]


  # GET /chats or /chats.json
  def index
    @pagy, @messages = pagy(Message.all, items: 30)
  end

  # GET /messages/1 or /messages/1.json
  def show
    authorize! @message
  end

  # GET /messages/new
  def new
    @message = Message.new
    authorize! @message, to: :create?
  end

  # GET /messages/1/edit
  def edit
    authorize! @message, to: :update?
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message.account = current_account
    authorize! @message, to: :create?

    chat_user = ChatUser.find_by(user_id: @message.account.id, chat_id: @message.chat.id)
    @message.acronym = chat_user.acronym
    @message.name = chat_user.name
    @message.color = chat_user.color
    @message.type = "ic"
    @message.posted = Time.now

    respond_to do |format|
      if @message.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("input_chat_#{@message.chat_id}", partial: "messages/form",
            locals: {message: Message.new(chat_id: @message.chat_id)}
          )
        end
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    authorize! @message, to: :update?
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    authorize! @message, to: :destroy?

    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:chat_id, :text)
    end
end
