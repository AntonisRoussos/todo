class ExpenseJournalsController < ApplicationController
  # GET /expense_journals
  # GET /expense_journals.xml
  def index
    @expense_journals = ExpenseJournal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expense_journals }
    end
  end

  # GET /expense_journals/1
  # GET /expense_journals/1.xml
  def show
    @expense_journal = ExpenseJournal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense_journal }
    end
  end

  # GET /expense_journals/new
  # GET /expense_journals/new.xml
  def new
    @expense_journal = ExpenseJournal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense_journal }
    end
  end

  # GET /expense_journals/1/edit
  def edit
    @expense_journal = ExpenseJournal.find(params[:id])
  end

  # POST /expense_journals
  # POST /expense_journals.xml
  def create
    @expense_journal = ExpenseJournal.new(params[:expense_journal])

    respond_to do |format|
      if @expense_journal.save
        format.html { redirect_to(@expense_journal, :notice => 'Expense journal was successfully created.') }
        format.xml  { render :xml => @expense_journal, :status => :created, :location => @expense_journal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense_journal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expense_journals/1
  # PUT /expense_journals/1.xml
  def update
    @expense_journal = ExpenseJournal.find(params[:id])

    respond_to do |format|
      if @expense_journal.update_attributes(params[:expense_journal])
        format.html { redirect_to(@expense_journal, :notice => 'Expense journal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense_journal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_journals/1
  # DELETE /expense_journals/1.xml
  def destroy
    @expense_journal = ExpenseJournal.find(params[:id])
    @expense_journal.destroy

    respond_to do |format|
      format.html { redirect_to(expense_journals_url) }
      format.xml  { head :ok }
    end
  end
end
