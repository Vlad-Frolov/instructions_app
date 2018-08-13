class StepsController < ApplicationController

    def edit
        secureEnter @step
    end

    def sort
        params[:order].each do |key,value|
          Step.find(value[:id]).update_attribute(:position,value[:position])
        end
      end

    private

    def set_step
      @step = Step.find(params[:id])
    end

end
