import { LightningElement, api } from "lwc";
export default class ConvertLead extends LightningElement {
    @api invoke() {
        console.log("Hi, I'm an action.");
      }
}