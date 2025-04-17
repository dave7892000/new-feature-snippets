class Admin::FoldersController < BaseAdminController
  before_action :set_folder, only: [:show, :update, :destroy]

  def new
    @folder = Folder.new
    # render :new
  end

  def index
    @folders = Folder.all
  end

  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      flash[:notice] = "New folder added successfully"
      if @folder.parent_folder_id.present?
        redirect_to admin_folder_path(@folder.parent_folder_id)
      else
        redirect_to admin_folders_url
      end
    else
      render :new
    end
  end

  def show
    @folders = Folder.where(parent_folder_id: params[:id])
    @new_file = SharedFile.new
    @files = SharedFile.where(folder_id: params[:id])
  end

  def update
    if @folder.update(folder_params)
      redirect_to admin_folder_path(@folder), notice: "Folder successfully updated."
    else
      redirect_to edit_admin_folder_path(@folder), notice: "Your Folder did not update."
    end
  end

  def destroy
    @folder = Folder.find(params[:id])

    if @folder.discard!
      flash.alert = "Folder deleted successfully."
      redirect_to admin_folders_path
    else
      redirect_to admin_folders_url
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :parent_folder_id)
  end

  def set_folder
    @folder = Folder.find(params[:id])
  end
end
