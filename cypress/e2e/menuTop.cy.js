/// <reference types="cypress" />

describe("E2E - akcja kliki", () => {
    it("kliki naglowka", () => {
        cy.visit("/");
        cy.get("li").parent("#categories_list").contains("Main dishes").click();
        cy.get("li").parent("#categories_list").contains("Pizza").click();
        cy.get("li").parent("#categories_list").contains("Soups").click();
        cy.get("li").parent("#categories_list").contains("Pasta").click();
        cy.get("li").parent("#categories_list").contains("Drinks").click();
        


        
    })
})
