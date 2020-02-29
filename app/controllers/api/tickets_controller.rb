 
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
     end
 end