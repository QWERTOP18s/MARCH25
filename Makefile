RAILS_PORT=3001
NEXTJS_PORT=3000
BACKEND_DIR=MARCH25API
FRONTEND_DIR=MARCH25CLIENT

rails:
	@echo "Starting Rails server on port $(RAILS_PORT)..."
	cd $(BACKEND_DIR) && bundle exec rails s -p $(RAILS_PORT) &

next:
	@echo "Starting Next.js server on port $(NEXTJS_PORT)..."
	cd $(FRONTEND_DIR) && npm run dev &


run: rails next

stop:
	@echo "Stopping servers..."
	-kill $(shell lsof -t -i:$(RAILS_PORT)) || true
	-kill $(shell lsof -t -i:$(NEXTJS_PORT)) || true
	@echo "Servers stopped."

install:
	@echo "Installing dependencies..."
	cd $(BACKEND_DIR) && bundle install
	cd $(FRONTEND_DIR) && npm install
	@echo "Dependencies installed."

clean: stop
	@echo "Cleaning up..."
	cd $(BACKEND_DIR) && rm -rf tmp/pids
	@echo "Cleanup complete."
