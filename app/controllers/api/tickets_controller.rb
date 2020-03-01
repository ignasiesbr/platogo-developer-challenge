 
 module Api
     class TicketsController < ApplicationController

        def get 
            tickets = Ticket.all()
            render json: tickets
        end

        def post
            ticket = Ticket.new()
            if ticket.save
                render json: {barcode: ticket.barcode, createdAt: ticket.created_at}, status: :ok
            else
                errorJson("Ticket not saved")
            end
        end

        def show
            ticket = Ticket.find_by(barcode: params[:barcode])
            if not ticket 
                return errorJson("Ticket not found")
            end
            price = calculatePrice(ticket)
            ticket.price = price
            if ticket.save
                render json: ticket, status: :ok
            else
                errorJson("Ticket not saved")
            end
        end

        def pay
            ticket = Ticket.find_by(barcode:params[:barcode])
            if not ticket 
                return errorJson("Ticket not found")
            end
            if ticket.is_paid 
                return errorJson("Ticket already paid")
            end
            if not isValidPaymentMethod(payment_params)
                return errorJson("Payment method not valid")
            end
            ticket.payment_method = payment_params
            ticket.is_paid = true
            ticket.payment_time = Time.zone.now
            ticket.price = 0
            if ticket.save
                render json: ticket, status: :ok
            else
                errorJson("Ticket not saved")
            end
        end

        private
        def calculatePrice(ticket)
            now = Time.zone.now
            current_hour = ticket.created_at
            hours = ((now - current_hour) / 3600).ceil
            hours * 2
        end

        def payment_params
            params.require(:payment_method)
        end

        def isValidPaymentMethod(payment_method)
            ["CREDIT_CARD", "DEBIT_CARD", "CASH"].include?(payment_method)
        end

        def errorJson(message)
            render json: {status: "ERROR", message: message}, status: :unprocessable_entity
        end

     end
 end