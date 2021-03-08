class SightingsController < ApplicationController

    def index
        sightings = Sighting.all
        if sightings
            render json: sightings.to_json(include: [:bird, :location])
        else
            render json: { message: 'No sighting found with that id' }
        end
    end


    def show
        sighting = Sighting.find_by(id: params[:id])

        if sighting
            # option 1
            # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }

            # option 2
            #render json: sighting, include: [:bird, :location]

            # option 3
            render json: sighting.to_json(:include => {
                :bird => {:only => [:name, :species]},
                :location => {:only => [:latitude, :longitude]}
            }, :except => [:updated_at])
        else
            render json: { message: 'No sighting found with that id' }
        end
    end
end
