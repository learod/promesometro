class PromesasController < ApplicationController
  #load_and_authorize_resource
  
  def denunciar
    @promesa = Promesa.new
    @promesa.info_funcionario = InfoFuncionario.new
    prueba = @promesa.pruebas.build
    prueba.link = Link.new
    prueba.archivo = Archivo.new
    prueba.imagen = Imagen.new
    prueba.video = Video.new
    prueba.mapa = Mapa.new
  end
  
  def ver
    @promesa = Promesa.find(params[:id])
    #@search = Promise.search(params[:search])
    @comments = @promesa.comment_threads.order('created_at desc').page(params[:page]).per(5)
  end
  
  def crear
    @promesa = Promesa.new(params[:promesa])
    @info_funcionario = @promesa.info_funcionario
    if @promesa.valid?
      @info_funcionario.save
      logger.debug current_ciudadano
      @promesa.uploader = current_ciudadano
      @promesa.pruebas.each_with_index do |p, idx|
        p.uploader = current_ciudadano
        p.posicion = idx if p.posicion.nil?
      end
      @promesa.save
      redirect_to ver_promesa_url(@promesa)
    else
      render :action => 'denunciar'
    end
  end
  
  def editar
    @promesa = Promesa.find(params[:id])
    render :template => 'promesas/denunciar'
  end
  
  def actualizar
    p = params[:promesa]
    @promesa = Promesa.find(p[:id])
#    p[:pruebas_attributes].each_with_index do |pb, idx|
#      puts "---------------- #{pb.to_yaml}"
#      if !pb[idx][:uploader_attributes]
#        pb[idx][:uploader_attributes][:id] = current_ciudadano.id
#      end
#    end
    if @promesa.update_attributes(p) 
      @promesa.save
      redirect_to :action => 'ver'
    else
      redirect_to :action => 'editar'
    end
  end
  
  def ver_todas
  end
  
  def buscar
    @search = PromesaSearch.new({params[:search].try(:to_sym) => params[:query]}, params[:page])
    @promesas = @search.promesas
  end
  
  def agregar_prueba
  end
  
  def comentar
    @promesa = Promesa.find(params[:id])
    @comment = Comment.build_from(
      @promesa,
      params[:comment][:ciudadano_id],
      params[:comment][:body]
    )
    @comment.save!
    flash[:notice]= 'El comentario ha sido creado con exito'
  
    redirect_to ver_promesa_url(@promesa)
  end
  
  def seguir
  end
  
  def reclamar_cumplimiento
  end
  
  def hacerse_cargo
  end
  
  def lavarse_las_manos
  end
end
