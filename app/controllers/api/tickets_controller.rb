 
 module Api
     class TicketsController < ApplicationController

        # Task 1
        def post
            tickets = Ticket.all
            if not existFreeSpaces(tickets)
                return errorJson("There are not any free spaces right now")
            end 
            ticket = Ticket.new()
            if ticket.save
                render json: {barcode: ticket.barcode, createdAt: ticket.created_at}, status: :ok
            else
                errorJson("Ticket not saved")
            end
        end

        # Task 2
        def show
            ticket = Ticket.find_by(barcode: params[:barcode])
            if not ticket 
                return errorJson("Ticket not found")
            end
            
            if not ticket.is_paid
                price = calculatePrice(ticket)
                ticket.price = price
            end
            if ticket.save
                render json: {barcode: ticket.barcode, price: ticket.price}, status: :ok
            else
                errorJson("Ticket not saved")
            end
        end

        # Task 3
        def pay
            ticket = Ticket.find_by(barcode:params[:barcode])
            if not ticket 
                return errorJson("Ticket not found")
            end
            if ticket.is_paid 
                return errorJson("Ticket already paid")
            end
            # Valid payment methods are CREDIT_CARD, CASH, DEBIT_CARD
            if not isValidPaymentMethod(payment_params)
                return errorJson("Payment method not valid")
            end
            ticket.payment_method = payment_params
            ticket.is_paid = true
            ticket.payment_time = Time.zone.now
            ticket.price = 0
            if ticket.save
                render json: {barcode: ticket.barcode, is_paid: ticket.is_paid, 
                    payment_time: ticket.payment_time, payment_method: ticket.payment_method}, status: :ok
            else
                errorJson("Ticket not saved")
            end
        end

        # Task 4
        def state
            ticket = Ticket.find_by(barcode:params[:barcode])
            if not ticket 
                return errorJson("Ticket not found") 
            end
            if not isPaymentValid(ticket)
                # if is not valid, re-pay
                ticket.is_paid = false
                ticket.price = 2
                ticket.payment_time = nil
                ticket.payment_method = nil
                ticket.save
                return render json: {barcode: ticket.barcode, is_paid: ticket.is_paid}
            else
                return render json: {barcode: ticket.barcode, is_paid: ticket.is_paid}, status: :ok
            end
        end

        # Task 5
        def free_spaces
            lot = Ticket.all
            free_spaces = 54 - lot.length
            render json: {free_spaces: free_spaces}, status: :ok
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

        def isPaymentValid(ticket)
            ticket.is_paid and ((Time.zone.now - ticket.payment_time) < (15 * 60)) ? true : false
        end

        def existFreeSpaces(tickets)
            return 54 - tickets.length > 0 ? true : false
        end
     end
 end