 
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
                render json: {status: ERROR, message: 'Ticket not saved'}, status: :unprocessable_entity
            end
        end

        def show
            ticket = Ticket.find_by(barcode: params[:barcode])
            price = calculatePrice(ticket)
            ticket.price = price
            render json: ticket
        end

        private
        def calculatePrice(ticket)
            now = Time.zone.now
            current_hour = ticket.created_at
            hours = ((now - current_hour) / 3600).ceil
            hours * 2
        end
     end
 end