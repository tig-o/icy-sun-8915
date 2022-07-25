class EmployeesController < ApplicationController
    def show
        @employee = Employee.find(params[:id])
    end

    def update
        employee = Employee.find(params[:id])
        # ticket = Ticket.find
        binding.pry
    end
end