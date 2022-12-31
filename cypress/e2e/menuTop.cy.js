/// <reference types="cypress" />

describe("E2E", () => {
    it("verify categories", () => {
        cy.visit("http://localhost:3000");
        cy.get("li").parent("#categories_list").contains("Main dishes").click();
        cy.get("li").parent("#categories_list").contains("Soups").click();
        cy.get("li").parent("#categories_list").contains("Drinks").click();
    })
})
