require 'rails_helper'

RSpec.describe 'employee show page' do
    it 'displays employees name and department' do
        department_1 = Department.create!(name: "Marketing", floor: "Sixth")
        department_2 = Department.create!(name: "IT", floor: "Basement")

        employee_1 = department_1.employees.create!(name: "Gunther", level: 2)
        employee_2 = department_1.employees.create!(name: "Selena", level: 5)
        employee_3 = department_2.employees.create!(name: "Tom", level: 7)
        employee_4 = department_2.employees.create!(name: "Jessi", level: 3)

        visit "/employees/#{employee_1.id}"

        expect(page).to have_content("Employee Name: Gunther")
        expect(page).to have_content("Department: Marketing")
        expect(page).to_not have_content("IT")
        expect(page).to_not have_content("Selena")
        expect(page).to_not have_content("Tom")
        expect(page).to_not have_content("Jessi")
    end

    it 'displays all of employee tickets from oldest to youngest' do
        department_1 = Department.create!(name: "Marketing", floor: "Sixth")
        department_2 = Department.create!(name: "IT", floor: "Basement")

        employee_1 = department_1.employees.create!(name: "Gunther", level: 2)
        employee_2 = department_1.employees.create!(name: "Selena", level: 5)
        employee_3 = department_2.employees.create!(name: "Tom", level: 7)
        employee_4 = department_2.employees.create!(name: "Jessi", level: 3)

        ticket_1 = Ticket.create!(subject: "Story board 2", age: 5)
        ticket_2 = Ticket.create!(subject: "Email partners", age: 1)
        ticket_3 = Ticket.create!(subject: "Plan Campaign 3", age: 10)
        ticket_4 = Ticket.create!(subject: "Plan Campaign 1", age: 7)

        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_1.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_2.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_3.id)
        EmployeeTicket.create!(employee_id: employee_2.id, ticket_id: ticket_4.id)

        visit "/employees/#{employee_1.id}"

        expect("Plan Campaign 3").to appear_before("Story board 2")
        expect("Story board 2").to appear_before("Email partners")
        expect(page).to_not have_content("Plan Campaign 1")
    end

    it 'displays oldest ticket separately' do
        department_1 = Department.create!(name: "Marketing", floor: "Sixth")
        department_2 = Department.create!(name: "IT", floor: "Basement")

        employee_1 = department_1.employees.create!(name: "Gunther", level: 2)
        employee_2 = department_1.employees.create!(name: "Selena", level: 5)
        employee_3 = department_2.employees.create!(name: "Tom", level: 7)
        employee_4 = department_2.employees.create!(name: "Jessi", level: 3)

        ticket_1 = Ticket.create!(subject: "Story board 2", age: 5)
        ticket_2 = Ticket.create!(subject: "Email partners", age: 1)
        ticket_3 = Ticket.create!(subject: "Plan Campaign 3", age: 10)
        ticket_4 = Ticket.create!(subject: "Plan Campaign 1", age: 15)

        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_1.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_2.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_3.id)
        EmployeeTicket.create!(employee_id: employee_2.id, ticket_id: ticket_4.id)

        visit "/employees/#{employee_1.id}"

        expect(page).to_not have_content("Plan Campaign 1")
        expect(page).to have_content(ticket_3.subject)
        # save_and_open_page
    end

    it 'displays a form to add a ticket to employee' do
        department_1 = Department.create!(name: "Marketing", floor: "Sixth")
        department_2 = Department.create!(name: "IT", floor: "Basement")

        employee_1 = department_1.employees.create!(name: "Gunther", level: 2)
        employee_2 = department_1.employees.create!(name: "Selena", level: 5)
        employee_3 = department_2.employees.create!(name: "Tom", level: 7)
        employee_4 = department_2.employees.create!(name: "Jessi", level: 3)

        ticket_1 = Ticket.create!(subject: "Story board 2", age: 5)
        ticket_2 = Ticket.create!(subject: "Email partners", age: 1)
        ticket_3 = Ticket.create!(subject: "Plan Campaign 3", age: 10)
        ticket_4 = Ticket.create!(subject: "Plan Campaign 1", age: 15)

        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_1.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_2.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_3.id)
        EmployeeTicket.create!(employee_id: employee_2.id, ticket_id: ticket_4.id)

        visit "/employees/#{employee_1.id}"

        expect(page).to_not have_content("Plan Campaign 1")
        
        fill_in :add_ticket, with: "Plan Campaign 1"
        click_button "Submit"
        expect(current_path).to eq("/employees/#{employee_1.id}")
        expect(page).to have_content("Plan Campaign 1")
    end
end