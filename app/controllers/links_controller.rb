class LinksController < ApplicationController

        def show
            lookup_code = link_params_show[:lookup_code]
            link = Link.find_by(lookup_code: lookup_code)
            if link
            redirect_to link.original_url , allow_other_host: true
            else
                redirect_to root_url   
            end
           # @link = Link.find(params[:linkid])
           # @xxx= params[:xxx]
         
        end
      
        def create
            

          @link = Link.new
          @link.original_url = link_params[:original_url]
          @link.lookup_code = lookup_code
          if valid_url?(@link.original_url) && @link.save
           redirect_to root_url, notice: 'Link created successfully!'
            #redirect_to show_link_path(linkid: @link.id, xxx: "passed through redirect", lookup_code: @link.lookup_code)
        else
            # Handle the case where the link couldn't be saved
            flash[:alert] = 'Invalid URL format. Please enter a valid URL.'
        
            render 'home/index'
          end

          
          
          #redirect_to @l
          
            
          
        end
       
        def lookup_code
            loop do
              code = get_fresh_code
              break code unless Link.exists?(lookup_code: code)
            end
          end
        
         
        
          def get_fresh_code
            SecureRandom.uuid[0..6]
          end
          private

          def link_params
            params.require(:link).permit(:original_url, :lookup_code)
          end

          def link_params_show
            params.permit(:original_url, :lookup_code)
          end

          def valid_url?(url)
            # Use a regular expression to check the URL format
            uri = URI.parse(url)
            uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
          rescue URI::InvalidURIError
            false
          end
      
      


end
