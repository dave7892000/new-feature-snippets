class Admin::SharedFilesController < BaseAdminController
  def show
    @shared_file = SharedFile.find(params[:id])
    @file = SharedFile.find(params[:id])
    redirect_to @file.url, allow_other_host: true
  end

  def create
    @file = SharedFile.new(shared_file_params)
    if @file.save
      flash[:notice] = "New file saved"
      redirect_to admin_folder_path(@file.folder_id)
    else
      render :new
    end
  end

  def destroy
    @shared_file = SharedFile.find(params[:id])
    folder_id = params[:folder_id]
    @folder = Folder.find(folder_id)

    if @shared_file.discard!
      flash.alert = "File deleted successfully"
      redirect_to admin_folder_path(@folder.id)
    else
      flash.alert = "There was an issue deleting this file"
    end
  end

  def shared_file_params
    params.require(:shared_file).permit(:url, :folder_id, :file_name)
  end
end
