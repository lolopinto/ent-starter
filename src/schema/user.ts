import { BaseEntSchema, Field,StringType } from "@lolopinto/ent";

export default class User extends BaseEntSchema {
    fields: Field[] = [
    StringType({ name: "FirstName" }),
    StringType({ name: "LastName" }),
    ];
}