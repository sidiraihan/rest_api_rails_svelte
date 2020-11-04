import { writable } from "svelte/store";

const storedKey = localStorage.getItem("key");
export const key = writable(storedKey);
key.subscribe(value => {
    localStorage.setItem("key", value);
});