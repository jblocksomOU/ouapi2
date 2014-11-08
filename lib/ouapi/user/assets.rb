module OUApi	
 class User

 	def assets
		OUApi.assets
	end

	def create_asset(params={name:random_string})
		new_asset = assets[:new]
		new_asset[:params].merge!(params)
		post(new_asset)
	end


#========Gallery Asset Methods==========================================
	def create_gallery(args)
		asset = args[:asset]
		images = args[:images]
		params = {type:3}
		params.merge!(asset)
		response = create_asset(params)
		asset = json_to_hash(response.body)
		asset_id = asset[:asset]
		response = add_gallery_images(asset_id,images)
	end


	def upload_gallery_image(args)
		path = "/assets/add_image"
		params = {
			site:@site,
			asset:"required",
			image:"#{random_string}.JPG",
			thumb_width:"10",
			thumb_height:"10"
		}
		image = {
			path:"required",
			name:"default",
			type:"img"
		}
		params.merge!(args[:params])
		image.merge!(args[:image])
		response = package(path:path,params:params,file:image)
	end

	def save_gallery_image(args)
		sleep 2
		image_id = args[:image_id]
		asset = args[:asset]
		title = args[:title] || ""
		description = args[:description] || ""
		caption = args[:caption] || ""
		link = args[:link] || ""
		params = {
            thumbnail_width:"100",
            thumbnail_height:"100",
            force_crop:false,
            advanced:"",
            site:@site,
            type:"3",
            asset:asset,
            images:"{'#{args[:image_id]}':{'title':'#{args[:title]}','description':'#{args[:description]}','caption':'#{args[:caption]}','link':'#{args[:link]}'}}"
        }
        puts params
        post(path:"/assets/save", params:params)
    end

    def add_gallery_image(asset_id,args)
			params = args[:params]
			params[:asset] = asset_id
			image = args[:image]
			response = upload_gallery_image(params:params,image:image)
			img = json_to_hash(response.body)
			img_id = img[:image]
			params[:image_id] = img_id
			save_gallery_image(params)
    end

    def add_gallery_images(asset_id,images)
    	images.each do |image|
    		add_gallery_image(asset_id,image)
    	end
    end
#========================================================================


 end
end

#gallery and form assets will need special treatment