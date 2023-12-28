class RedeemController < ApplicationController
  before_action :authenticate_account!
  before_action :set_beta_code

  def consume
    if @beta_code
      respond_to do |format|
        format.html { redirect_to redeem_path, notice: "This account already has beta access." }
        format.json { render :index, status: :unprocessable_entity }
      end
    else
      code = beta_code_params
      @beta_code = BetaCode.find_by(code: code, account_id: nil)
      if @beta_code
        @beta_code.account = current_account
        respond_to do |format|
          if @beta_code.save
            format.html { redirect_to redeem_path, notice: "Beta access obtained." }
            format.json { render :index, status: :ok }
          else
            format.html { redirect_to redeem_path, status: :unprocessable_entity }
            format.json { render json: @beta_code.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to redeem_path, status: :unprocessable_entity }
          format.json { render :index, status: :unprocessable_entity }
        end
      end
    end
  end

  private 
    def set_beta_code
      @beta_code = current_account.beta_code
    end

    def beta_code_params
      params.require(:code)
    end
end
