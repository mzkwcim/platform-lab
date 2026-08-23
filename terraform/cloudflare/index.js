export default {
  async fetch(request) {
    const url = new URL(request.url);

    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type, Authorization",
    };

    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    if (url.pathname === "/health") {
      return Response.json(
        {
          status: "ok",
          time: new Date().toISOString(),
        },
        {
          headers: corsHeaders,
        }
      );
    }

    return new Response("Not found", {
      status: 404,
      headers: corsHeaders,
    });
  },
};