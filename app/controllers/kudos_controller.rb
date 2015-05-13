class KudosController < ApplicationController
  before_action :session_required, except: [:index, :sent]
  before_action :verify_api_access_for_xml_request, only: [:index, :sent]
  before_action :find_account, only: [:index, :sent]
  before_action :find_account_or_contribution, only: [:new, :create]
  before_action :find_kudo, only: [:destroy]
  before_action :make_new_kudo, only: [:new, :create]

  before_action :account_context

  def index
    @person = @account.person
    @received_kudos = @account.kudos.sort_by_created_at
    @sent_kudos = @account.sent_kudos.sort_by_created_at
  end

  def sent
    @sent_kudos = @account.sent_kudos
  end

  def new
    render layout: false
  end

  def create
    @kudo.save
    redirect_to :back
  end

  def destroy
    if current_user == @kudo.sender || current_user == @kudo.account
      @kudo.destroy
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
    end
    redirect_to :back
  end

  private

  def find_account
    @account = Account.from_param(params[:account_id]).take
    fail ParamRecordNotFound unless @account
  end

  def find_account_or_contribution
    p = params[:kudo] || params
    @account = Account.from_param(p[:account_id]).take
    @contribution = Contribution.where(id: p[:contribution_id]).take
    fail ParamRecordNotFound unless @account || @contribution
  end

  def find_kudo
    @kudo = Kudo.where(id: params[:id]).take
    fail ParamRecordNotFound if @kudo.nil?
  end

  def make_new_kudo
    @kudo = Kudo.new(message: (params[:kudo] && params[:kudo][:message]), sender: current_user, account: @account)
    @kudo.assign_attributes(project: @contribution.project, name: @contribution.name_fact.name) if @contribution
  end
end
