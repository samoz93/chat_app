
/*
 * -------------------------------------------------------
 * THIS FILE WAS AUTOMATICALLY GENERATED (DO NOT MODIFY)
 * -------------------------------------------------------
 */

/* tslint:disable */
/* eslint-disable */

export interface NewUserInput {
    email: string;
    password: string;
    name: string;
}

export interface User {
    id: string;
    name: string;
    email: string;
    createdAt?: Nullable<Date>;
    updatedAt?: Nullable<Date>;
}

export interface AuthPayload {
    token: string;
    user: User;
}

export interface IQuery {
    user(id: string): User | Promise<User>;
    test(): User[] | Promise<User[]>;
    refresh(): AuthPayload | Promise<AuthPayload>;
}

export interface IMutation {
    updateUser(id: string, name: string, email: string, password: string): User | Promise<User>;
    deleteUser(id: string): User | Promise<User>;
    login(email: string, password: string): AuthPayload | Promise<AuthPayload>;
    signUp(data: NewUserInput): AuthPayload | Promise<AuthPayload>;
}

type Nullable<T> = T | null;
