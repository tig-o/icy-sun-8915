require 'rails_helper'

RSpec.describe 'department index page' do
    it 'displays each departments name with floor and their employees' do
        department_1 = Department.create!(name: "Marketing", floor: "Sixth")
        department_2 = Department.create!(name: "IT", floor: "Basement")
        department_3 = Department.create!(name: "Accounting", floor: "Third")

        employee_1 = department_1.employees.create!(name: "Gunther", level: 2)
        employee_2 = department_1.employees.create!(name: "Selena", level: 5)
        employee_3 = department_2.employees.create!(name: "Tom", level: 7)
        employee_4 = department_2.employees.create!(name: "Jessi", level: 3)
        employee_5 = department_3.employees.create!(name: "Vicktor", level: 1)
        employee_6 = department_3.employees.create!(name: "Erica", level: 8)
        employee_7 = department_3.employees.create!(name: "Nicole", level: 9)

        visit "/departments"

        within "#department-#{department_1.id}" do
            expect(page).to have_content("Name: Marketing")
            expect(page).to have_content("Floor: Sixth")
            expect(page).to have_content("Gunther")
            expect(page).to have_content("Selena")
            expect(page).to_not have_content("IT")
            expect(page).to_not have_content("Nicole")
            expect(page).to_not have_content("Jessi")
        end

        within "#department-#{department_2.id}" do
            expect(page).to have_content("Name: IT")
            expect(page).to have_content("Floor: Basement")
            expect(page).to have_content("Tom")
            expect(page).to have_content("Jessi")
            expect(page).to_not have_content("Accounting")
            expect(page).to_not have_content("Nicole")
            expect(page).to_not have_content("Selena")
        end

        within "#department-#{department_3.id}" do
            expect(page).to have_content("Name: Accounting")
            expect(page).to have_content("Floor: Third")
            expect(page).to have_content("Nicole")
            expect(page).to have_content("Erica")
            expect(page).to have_content("Vicktor")
            expect(page).to_not have_content("IT")
            expect(page).to_not have_content("Gunther")
            expect(page).to_not have_content("Selena")
        end
    end
end