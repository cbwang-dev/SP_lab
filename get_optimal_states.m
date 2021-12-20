function q = get_optimal_states(hmm, features)
%GET_OPTIMAL_STATES Calculate the most likely sequence of states given the observed emissions using viterbi algorithm.
% input: hmm - a HMM structure with initialized parameters
%        features - [T nbFeatures] vector
%   
% output: q - the most likely sequence of states

    N = hmm.N;
    emis = hmm.emis;
    init = hmm.init;
    trans = hmm.trans;
    T = size(features,1);

    delta = zeros(T,N);
    psi = zeros(T,N);

    for i=1:N
        b = gen_pdf(features(1,:), emis(i).mean, emis(i).cov); % = b_i(O_1)
        delta(1,i) = b*init(i);
    end

    for t=2:T
        for j=1:N
            b = gen_pdf(features(t,:), emis(j).mean, emis(j).cov); % = b_i(O_t)
            [val, index] = max( delta(t-1,:).*trans(:,j)' );
            delta(t,j) =  val * b;
            psi(t,j) = index;
        end
    end

    q = zeros(T,1);
    [~, index] = max(delta(T,:));
    q(T) = index;
    q_next = q(T);
    for t=T-1:-1:1
        q(t) = psi(t+1, q_next);
        q_next = q(t);
    end
end

