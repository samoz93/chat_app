
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
    rooms?: Nullable<ChatRoom[]>;
    ownerRooms?: Nullable<ChatRoom[]>;
    createdAt?: Nullable<Date>;
    updatedAt?: Nullable<Date>;
    friends?: Nullable<Nullable<User>[]>;
}

export interface AuthPayload {
    token: string;
    refreshToken: string;
    user: User;
}

export interface Message {
    id: string;
    text: string;
    user: User;
    createdAt?: Nullable<Date>;
    updatedAt?: Nullable<Date>;
}

export interface ChatRoom {
    id: string;
    name: string;
    description: string;
    owner: User;
    users: User[];
    messages: Message[];
}

export interface IQuery {
    user(id: string): User | Promise<User>;
    test(): User[] | Promise<User[]>;
    refresh(refreshToken?: Nullable<string>): AuthPayload | Promise<AuthPayload>;
    getRooms(page?: Nullable<number>, limit?: Nullable<number>): ChatRoom[] | Promise<ChatRoom[]>;
    getFriends(): User[] | Promise<User[]>;
}

export interface IMutation {
    updateUser(id: string, name: string, email: string, password: string): User | Promise<User>;
    deleteUser(id: string): User | Promise<User>;
    login(email: string, password: string): AuthPayload | Promise<AuthPayload>;
    signUp(data: NewUserInput): AuthPayload | Promise<AuthPayload>;
    createRoom(name: string, description: string): ChatRoom | Promise<ChatRoom>;
}

type Nullable<T> = T | null;
