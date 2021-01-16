<template>
  <section class="section">
    <template v-if="$fetchState.pending"> placeholder </template>
    <ul v-for="(todo, index) in todos" :key="todo.id">
      <li>
        <nuxt-link :to="'/todo/' + todo.id">{{ todo.title }}</nuxt-link>
        {{index}} {{todo.done}}
        <b-button
          v-if="!todo.done"
          type="is-primary"
          icon-left="check"
          @click="UpdateStatus(index, todo, true)"
          >Mark Done</b-button
        >
        <b-button
          v-if="todo.done"
          type="is-primary"
          icon-left="check"
          @click="UpdateStatus(index, todo, false)"
          >Mark Not Done</b-button
        >
      </li>
    </ul>

    <b-input v-model="todo.title" required></b-input>
    <b-button type="is-primary" icon-left="check" @click="CreateTodo()"
      >Create new todo</b-button
    >
  </section>
</template>
<script>
export default {
  data() {
    return {
      todos: [
        {
          id: null,
          title: null,
        },
      ],
      todo: { title: null, done: false },
    };
  },
  async fetch() {
    // request to API server for list of items
    await this.$axios.get("http://localhost:4000/api/todos").then((response) => {
      this.todos = response.data.data;
    });
  },
  methods: {
    async CreateTodo() {
      await this.$axios.post("http://localhost:4000/api/todos", {
        todo: this.todo,
      });
      await this.$axios
        .get("http://localhost:4000/api/todos")
        .then((response) => {
          this.todos = response.data.data;
        });
      this.todo.title = null;
    },
    async UpdateStatus(index, todo, done) {
      const updated_todo = await this.$axios
        .patch("http://localhost:4000/api/todos/" + todo.id, {
          todo: { done: done },
        })
        .then((response) => response.data.data)

        console.log(updated_todo)
        this.$set(this.todos, index, updated_todo)
        console.log(this.todo[index])
    },
  },
};
</script>