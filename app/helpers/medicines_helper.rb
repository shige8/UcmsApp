module MedicinesHelper
  def took_medicine
    @current_user = current_user
    gon.user = @currnet_user
    @now = Time.now.strftime("%H:%M")
    gon.now = @now

    if logged_in?
      @tookmedicinelast = current_user.medicines.where.not(took_medicine_at: nil).last
      if @tookmedicinelast
        @tooklastat = @tookmedicinelast.took_medicine_at
        gon.medicine = @tooklastat
      end

      @medicineslast = current_user.medicines.last
      if @medicineslast
        if current_user.medicines.where.not(gonna_take_medicine_at: nil).last
          @gonnatake = @medicineslast.gonna_take_medicine_at.strftime("%H:%M")
          gon.gonnatake = @gonnatake
        end
      end

      @no = current_user.medicines.where(took_medicine_at: nil).last
      gon.noexist = @no
      # if @no
      #   @noid = @no.id
      #   gon.noid = @noid
      # end

      @p = "post"
      gon.p = @p
    end
  end
end
