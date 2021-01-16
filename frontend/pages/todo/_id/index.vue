<template>
  <section class="section">
    <nuxt-link to="/todo">Back</nuxt-link>
    <template v-if="$fetchState.pending"> placeholder </template>
    {{ todo.title }}
    <b-input v-model="new_todo.title" required></b-input>
    <b-button type="is-primary" icon-left="check" @click="EditTodo(todo)"
      >Edit todo</b-button
    >
    <b-button type="is-danger" @click="DeleteTodo(todo)" icon-right="delete" />
  </section>
</template>
<script>
export default {
  data() {
    return {
      todo: { title: "", done: false },
      new_todo: { title: "", done: false },
    };
  },
  async fetch() {
    // request to API server for list of items
    const todo = await this.$axios
      .get("http://localhost:4000/api/todos/" + this.$route.params.id)

    this.todo = todo.data.data;
  },
  methods: {
    async EditTodo(todo) {
      await this.$axios
        .put("http://localhost:4000/api/todos/" + todo.id, {
          todo: { title: this.new_todo.title, done: this.todo.done },
        })
        .then((response) => {
          this.todo = response.data.data;
        });
    },
    async DeleteTodo(todo) {
      await this.$axios.delete("http://localhost:4000/api/todos/" + todo.id);
      await this.$router.push("/todo");
    },
  },
};
</script>